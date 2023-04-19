const app = require('./index');
const chai = require('chai');
const chaiHttp = require('chai-http');

chai.use(chaiHttp);
const expect = chai.expect;

describe('app', function() {
  it('should return Hello World, welcome! on GET /', function(done) {
    chai.request(app)
      .get('/')
      .end(function(err, res) {
        expect(res).to.have.status(200);
        expect(res.text).to.equal('Hello World, welcome!');
        done();
      });
  });

  it('should return Olá Mundo, seja bem-vindo! on GET /pt', function(done) {
    chai.request(app)
      .get('/pt')
      .end(function(err, res) {
        expect(res).to.have.status(200);
        expect(res.text).to.equal('Olá Mundo, seja bem-vindo!');
        done();
      });
  });

  

  it('should return Hallo Welt, willkommen!! on GET /de', function(done) {
    chai.request(app)
      .get('/de')
      .end(function(err, res) {
        expect(res).to.have.status(200);
        expect(res.text).to.equal('Hallo Welt, willkommen!!');
        done();
      });
  });

  it('should return OK on GET /healthz', function(done) {
    chai.request(app)
      .get('/healthz')
      .end(function(err, res) {
        expect(res).to.have.status(200);
        done();
      });
  });
});

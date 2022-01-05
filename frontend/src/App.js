import { Component } from 'react';
import { BrowserRouter as Router, Routes, Route} from 'react-router-dom';
import Dash from './views/dash/dash';
import Main from './views/reg/main';
import Schedule from './views/reg/schedule';

class App extends Component {
  render() {
    return (
      <>
        <Router>
          <Routes>
            <Route exact path = "/" element = {<Dash/>} />
            <Route path = "/main" element = {<Main/>} />
            <Route path = "/register" element = {<Schedule/>} />
          </Routes>
        </Router>
      </> 
    );
  }
}

export default App;
